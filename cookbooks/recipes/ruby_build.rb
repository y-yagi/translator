execute 'yum groupinstall "Development Tools"'
package "git"
package "zsh"
package "openssl-devel"
package "readline-devel"

RBENV_ROOT = "/usr/local/rbenv"
RBENV_INIT = <<-EOS
  export RBENV_ROOT=#{RBENV_ROOT}
  export PATH="#{RBENV_ROOT}/bin:${PATH}"
  eval "$(rbenv init --no-rehash -)"
EOS

git RBENV_ROOT do
  repository "git://github.com/sstephenson/rbenv.git"
end

git "#{RBENV_ROOT}/plugins/ruby-build" do
  repository "git://github.com/sstephenson/ruby-build.git"
end

node[:rbenv][:versions].each do |version|
  execute "rbenv install #{version}" do
    command "#{RBENV_INIT} rbenv install #{version}"
    not_if  "#{RBENV_INIT} rbenv versions | grep #{version}"
  end
end

node[:rbenv][:global].tap do |version|
  execute "rbenv global #{version}" do
    command "#{RBENV_INIT} rbenv global #{version}"
    not_if  "#{RBENV_INIT} rbenv version | grep #{version}"
  end
end

node[:rbenv][:gems].each do |gem|
  execute "gem install #{gem}" do
    command "#{RBENV_INIT} gem install #{gem}; rbenv rehash"
    not_if  "#{RBENV_INIT} gem list | grep #{gem}"
  end
end
