class Grabeni < Formula
  grabeni_version = '0.4.1'
  homepage 'https://github.com/yuuki1/grabeni'
  version grabeni_version

  if Hardware.is_64_bit?
    url "https://github.com/yuuki1/grabeni/releases/download/v#{grabeni_version}/grabeni_darwin_amd64.zip"
    sha256 'a47dc0f46870ecd2d6c5fbd52cdc618a7dd27dc5c7a98bf671f33593aa35c319'
  else
    url "https://github.com/yuuki1/grabeni/releases/download/v#{grabeni_version}/grabeni_darwin_386.zip"
    sha256 '8fd6101bfe33634bf18c10ad2a715ad1bc721e9bb9b9653f9a9a8bc95d59145d'
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
