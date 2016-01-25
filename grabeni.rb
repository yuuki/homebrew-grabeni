class Grabeni < Formula
  grabeni_version = '0.3.1'
  homepage 'https://github.com/yuuki1/grabeni'
  version grabeni_version

  if Hardware.is_64_bit?
    url "https://github.com/yuuki1/grabeni/releases/download/v#{grabeni_version}/grabeni_darwin_amd64.zip"
    sha256 '3c2232031fedf2fb86eb0b1eb90d5d22424d485344ab6681725cfdd811b8fedd'
  else
    url "https://github.com/yuuki1/grabeni/releases/download/v#{grabeni_version}/grabeni_darwin_386.zip"
    sha256 '1b2a812c94814934eb54823d6e467462f9c4b0641f161dbaf27c3ab1ba643e55'
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
