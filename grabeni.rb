class Grabeni < Formula
  grabeni_version = '0.3.0'
  homepage 'https://github.com/yuuki1/grabeni'
  version grabeni_version

  if Hardware.is_64_bit?
    url "https://github.com/yuuki1/grabeni/releases/download/v#{grabeni_version}/grabeni_darwin_amd64.zip"
    sha256 '11d103b5b634e34fcf49163ed18354353fbdd50bbc40a4d50ebb0dceff7fa974'
  else
    url "https://github.com/yuuki1/grabeni/releases/download/v#{grabeni_version}/grabeni_darwin_386.zip"
    sha256 '9001d72e22916974a9a96d1e6f7104dbc7249ad7c508ead619ea3e31ccc05ae1'
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
