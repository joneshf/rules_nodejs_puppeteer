"""Dependencies needed for `chromium`.
"""

load(
    "@bazel_tools//tools/build_defs/repo:http.bzl",
    "http_archive",
)

# `puppeteer`/`puppeteer-core` is only guaranteed to work with a single `chromium` revision.
# If the version of `puppeteer`/`puppeteer-core` is updated,
# this revision must match exactly.
#
# We can find the revision for the specific version of `puppeteer`/`puppeteer-core` at:
# https://github.com/puppeteer/puppeteer/blob/<version>/src/revisions.ts#L23
# E.g. For version v9.1.1:
# https://github.com/puppeteer/puppeteer/blob/v9.1.1/src/revisions.ts#L23
_revision = "869685"

def chromium_dependencies():
    """Fetch dependencies for `chromium`.

    Since `chromium` is a dependency we use (rather than an artifact we create),
    We want to keep its dependencies separate from ours.
    """

    http_archive(
        name = "chromium_linux",
        build_file = "//vendor/chromium:linux.BUILD",
        sha256 = "ce7d13e538c30d9d191049a16c3522620dd30151d8cfb24ee0d4b44c5fa1bb4a",
        urls = [
            "https://www.googleapis.com/download/storage/v1/b/chromium-browser-snapshots/o/Linux_x64%2F{revision}%2Fchrome-linux.zip?alt=media".format(
                revision = _revision,
            ),
        ],
    )

    http_archive(
        name = "chromium_macos",
        build_file = "//vendor/chromium:macos.BUILD",
        sha256 = "af28ce1a7fe699791d5d884e45693cabd1c2ab09de8bd8327265a57eaea128cf",
        urls = [
            "https://www.googleapis.com/download/storage/v1/b/chromium-browser-snapshots/o/Mac%2F{revision}%2Fchrome-mac.zip?alt=media".format(
                revision = _revision,
            ),
        ],
    )

    http_archive(
        name = "chromium_windows",
        build_file = "//vendor/chromium:windows.BUILD",
        sha256 = "3ad719ea11e40a7f6024912ea5c1d24311fe04ba005aea971746d4ddbfe52069",
        urls = [
            "https://www.googleapis.com/download/storage/v1/b/chromium-browser-snapshots/o/Win_x64%2F{revision}%2Fchrome-win.zip?alt=media".format(
                revision = _revision,
            ),
        ],
    )
