#!/usr/bin/env python3

import os
from pathlib import Path
import sys
import subprocess
import re
import anitopy
import argparse
import shutil


class PlaylistManager:
    ILLEGAL = r'[\\/:"*?<>|]+'

    try:
        DEFAULT_HANDLER = {"win32": "explorer", "linux": "xdg-open", "darwin": "open"}[
            sys.platform
        ]
        handler = (
            "mpv"
            if sys.platform == "linux" and shutil.which("mpv")
            else DEFAULT_HANDLER
        )

    except KeyError:
        print("Unsupported OS")
        sys.exit(1)

    ANITOPY_OPTION = {"allowed_delimiters": " _.&+,|\t"}

    EXT = re.compile(
        r"^.*\.(mkv|mk3d|webm|ogm|ogv|flv|avi|divx|xvid|rm|rmvb|vob|flv|mts|ts|m2ts|mov|qt|wmv|yuv|asf|amv|m4v|m4p|mpg|mpeg|mpv|mpe|mpeg|m2v|3gp|3gp2|mp4)$",
        re.IGNORECASE,
    )
    EPISODE_NUMBER = re.compile(
        r"(?<=p|\s|\W|:|-|e|E|_|\.)([^a-dA-Df-oF-Oq-zQ-Z](p|P)?(_-\.)?)(\d{1,4}|ova|oad)([^pP](_-\.)?)(?![a-uw-zA-UW-Z]|.{1,5}\.mkv|\d{1,3}|-bit)",
        re.IGNORECASE,
    )

    def __init__(
        self,
        directory: Path,
        playlist_file: Path,
        start_from_beginning: bool = False,
        queue_multiple: bool = False,
    ):
        """Initialize the manager with directory, playlist paths, and play mode."""
        self.directory = directory.resolve()
        self.playlist_file = (
            playlist_file.resolve()
            if playlist_file.exists()
            else self.directory / "playlist.m3u8"
        )
        self.episode_list = []
        self.start_from_beginning = (
            start_from_beginning  # Start from beginning or continue
        )
        self.queue_multiple = queue_multiple  # Play all or just continue

    def parse_episode_number(self, file_name: str) -> float:
        """Extracts the episode number using regex."""
        match = PlaylistManager.EPISODE_NUMBER.findall(file_name)
        return float(match[0][3]) if match else 999999

    def reorder_episode_list(self):
        """Sorts the episode list based on multiple attributes."""
        self.episode_list.sort(key=lambda x: float(x.get("episode_number", 999999)))
        self.episode_list.sort(key=lambda x: x.get("anime_title", ""))
        self.episode_list.sort(key=lambda x: x.get("release_group", ""))
        self.episode_list.sort(key=lambda x: x["file_name"].replace("\t", ""))

    def read_playlist_file(self) -> list[str]:
        """Reads the playlist file and returns its content."""
        try:
            with self.playlist_file.open("r", encoding="utf-8") as f:
                return f.read().splitlines()
        except FileNotFoundError:
            return []

    def write_playlist_file(self, text: list[str]):
        """Writes the updated playlist back to the file."""
        with self.playlist_file.open("w", encoding="utf-8") as f:
            f.write("\n".join(text))

    def process_playlist(self) -> tuple[int, str, list]:
        """Processes the playlist, finds the next file(s) to play, and updates the list."""
        valid_files = [
            f.resolve().name
            for f in self.directory.iterdir()
            if PlaylistManager.EXT.match(f.name)
        ]
        playlist = self.read_playlist_file()
        new_files = False

        saved_file = next(filter(lambda x: x.startswith("\t"), playlist), None)

        if len(valid_files) != len(
            playlist
        ):  # Update playlist if new files are detected
            playlist = valid_files
            new_files = True

        if not playlist:
            raise Exception("No files found.")

        self.episode_list = [
            anitopy.parse(file_name, options=PlaylistManager.ANITOPY_OPTION)
            for file_name in playlist
        ]

        for ep in self.episode_list:
            if ep and "episode_number" not in ep:
                ep["episode_number"] = self.parse_episode_number(ep["file_name"])

        self.reorder_episode_list()

        playlist = list(map(lambda x: x["file_name"], self.episode_list))

        if saved_file:
            if new_files:
                saved_file = saved_file.replace("\t", "")
            saved_index = playlist.index(saved_file)
            playlist[saved_index] = saved_file.replace("\t", "")  # Unmark file
        else:
            saved_index = 0
        next_index = saved_index + 1 if saved_index + 1 < len(playlist) else 0

        next_file = playlist[next_index]
        playlist[next_index] = "\t" + playlist[next_index]  # Mark next file

        return next_index, next_file, playlist

    def play_videos(self):
        """Plays the video(s) based on selection and updates the playlist file."""
        try:
            video_index, video, updated_text = self.process_playlist()
        except Exception:
            input("Waiting...")
            sys.exit()

        # Using MPV logic assumption
        args = PlaylistManager.handler.split(" ")

        if "mpv" in args:
            # args.append("--no-terminal")
            args.append("--screen=0")
            args.append("--fs-screen=current")
            args.append("--fs")

        if self.start_from_beginning or self.queue_multiple:
            args.append("--")
            video_paths = list(
                map(
                    # lambda x: str(
                    #     (self.directory / Path(x.replace("\t", "")))
                    #     .expanduser()
                    #     .resolve()
                    # ),
                    lambda x: (self.directory / Path(x.replace("\t", "")))
                    .expanduser()
                    .resolve(),
                    updated_text
                    if self.start_from_beginning
                    else updated_text[video_index:],
                )
            )
            args.extend(video_paths)
        else:
            # Default behaviour
            filepath = self.directory / Path(video)
            if not filepath.exists():
                raise Exception(f"Does not exist? {str(filepath)}")
            args.append(filepath.expanduser().resolve())
            # args.append(str(filepath.expanduser().resolve()).strip("'").strip('"'))

        done = subprocess.run(args, capture_output=True, shell=False)

        if done.stderr and done.returncode:
            print("MPV Playlist Manager did not work as expected.")
            print(f"See {done.returncode}: {done.stderr}")
        else:
            self.write_playlist_file(updated_text)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Manage and play videos from a playlist."
    )
    group = parser.add_mutually_exclusive_group()
    group.add_argument(
        "--continue",
        "-c",
        action="store_true",
        help="Play all episodes starting from the next.",
        default=False,
    )
    group.add_argument(
        "--all",
        "-a",
        action="store_true",
        help="Play all episodes starting from the very first. Implies --continue",
        default=False,
    )
    parser.add_argument(
        "--directory",
        "-d",
        type=str,
        help="Directory to work in.",
        default=str(Path.cwd()),
    )

    args = parser.parse_args()

    directory = Path(args.directory).expanduser().resolve()

    manager = PlaylistManager(
        directory,
        directory / "playlist.m3u8",
        start_from_beginning=getattr(args, "all"),
        queue_multiple=getattr(args, "all") or getattr(args, "continue"),
    )
    manager.play_videos()
