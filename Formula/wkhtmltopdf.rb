class Wkhtmltopdf < Formula
  desc "Convert HTML to PDF using Webkit (QtWebKit)"
  homepage "https://wkhtmltopdf.org"
  url "https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6-2/wkhtmltox-0.12.6-2.macos-cocoa.pkg"
  version "0.12.6-2"
  sha256 "81a66b77b508fede8dbcaa67127203748376568b3673a17f6611b6d51e9894f8"
  license "GPL-3.0-or-later"

  # We need to check all releases since not all releases are for macOS.
  livecheck do
    url "https://github.com/wkhtmltopdf/packaging/releases"
    strategy :page_match
    regex(/href=.*?wkhtmltox-(\d+(?:\.\d+)*-\d+)\.macos-cocoa\.pkg/i)
  end

  bottle :unneeded

  def install
    system "pkgutil", "--expand-full", "wkhtmltox-#{version}.macos-cocoa.pkg", "wkhtmltox-#{version}.macos-cocoa"
    system "tar", "ozxf", "wkhtmltox-#{version}.macos-cocoa/Payload/usr/local/share/wkhtmltox-installer/wkhtmltox.tar.gz", "-C", prefix
    mv "wkhtmltox-#{version}.macos-cocoa/Payload/usr/local/share/wkhtmltox-installer/uninstall-wkhtmltox", bin
  end

  test do
    system "wkhtmltopdf", "--help"
  end
end
