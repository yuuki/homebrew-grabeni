class Grabeni < Formula
  grabeni_version = '0.4.2'
  homepage 'https://github.com/yuuki/grabeni'
  version grabeni_version

  if Hardware::CPU.is_64_bit?
    url "https://github.com/yuuki/grabeni/releases/download/v#{grabeni_version}/grabeni_darwin_amd64.zip"
    sha256 'c1ed6fc955d8109435957cf47069129ee58f494fd8fbb68a4e82733a16284f41'
  else
    url "https://github.com/yuuki/grabeni/releases/download/v#{grabeni_version}/grabeni_darwin_386.zip"
    sha256 '3e30f16f0ec41ab92ceca57a527efff18b6bacabd12a842afda07b8329e32259'
  end

  head do
    url 'https://github.com/yuuki/grabeni.git'
    depends_on 'go' => :build
    depends_on 'git' => :build
  end

  def install
    if build.head?
      ENV['GOPATH'] = buildpath/'.go'
      mkdir_p buildpath/'.go/src/github.com/yuuki'
      ln_s buildpath, buildpath/'.go/src/github.com/yuuki/grabeni'
      system 'make', 'build'
    end
    bin.install 'grabeni'
  end

  test do
    system 'grabeni', '--version'
  end
end
