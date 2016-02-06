class Grabeni < Formula
  grabeni_version = '0.4.0'
  homepage 'https://github.com/yuuki1/grabeni'
  version grabeni_version

  if Hardware.is_64_bit?
    url "https://github.com/yuuki1/grabeni/releases/download/v#{grabeni_version}/grabeni_darwin_amd64.zip"
    sha256 'b45a1a6ae9525f92209957aea86cdb0be24e644ffe2cf5d0a8a58aff190a8fd9'
  else
    url "https://github.com/yuuki1/grabeni/releases/download/v#{grabeni_version}/grabeni_darwin_386.zip"
    sha256 'b94c498bfc28db966b3ed5d8948d5d12b34328291c002cef3f5a330e28b2b24f'
  end

  head do
    url 'https://github.com/yuuki1/grabeni.git'
    depends_on 'go' => :build
    depends_on 'git' => :build
  end

  def install
    if build.head?
      ENV['GOPATH'] = buildpath/'.go'
      mkdir_p buildpath/'.go/src/github.com/yuuki1'
      ln_s buildpath, buildpath/'.go/src/github.com/yuuki1/grabeni'
      system 'make', 'build'
    end
    bin.install 'grabeni'
  end

  test do
    system 'grabeni', '--version'
  end
end
