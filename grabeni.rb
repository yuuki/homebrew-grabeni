class Grabeni < Formula
  grabeni_version = '0.4.1'
  homepage 'https://github.com/yuuki/grabeni'
  version grabeni_version

  if Hardware::CPU.is_64_bit?
    url "https://github.com/yuuki/grabeni/releases/download/v#{grabeni_version}/grabeni_darwin_amd64.zip"
    sha256 '628507fffbd8895acc2e00b2ab2a8c7f970a3dad3775a8517bb452616ff024af'
  else
    url "https://github.com/yuuki/grabeni/releases/download/v#{grabeni_version}/grabeni_darwin_386.zip"
    sha256 '2010472e4e4a178d6c565442190c627f3c5944f33089f659affcc0c84a5e889c'
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
