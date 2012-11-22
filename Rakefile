namespace :jekyll do

  desc 'Delete generated _site files'
  task :clean do
    system "rm -fR _site"
  end

  desc 'Run the jekyll dev server'
  task :server do
    system "jekyll --server --auto"
  end

  desc 'Clean temporary files and run the server'
  task :compile => [:clean, 'compass:clean', 'compass:compile'] do
    system "jekyll"
  end

end

namespace :deploy do
  desc 'Deploy to production'
  task :prod => ['dev:off'] do
    system "cap deploy"
  end

end

namespace :compass do

  desc 'Delete temporary compass files'
  task :clean do
    system "rm -fR css/*"
  end

  desc 'Run the compass watch script'
  task :watch do
    system "compass watch"
  end

  desc 'Compile sass scripts'
  task :compile => [:clean] do
    system "compass compile"
  end

end

namespace :pygments do

  desc 'Delete pygments CSS files'
  task :clean do
    system "rm -f _sass/3rd_party/pygments/*.scss"
  end

  desc 'Generate pygments CSS'
  task :compile => [:clean] do
    system "mkdir -p _sass/3rd_party/pygments"
    system "pygmentize -S default -f html > _sass/3rd_party/pygments/default.scss"
  end

end

namespace :dev do

  desc 'Un-publish old posts to speed up development'
  task :on => ['jekyll:clean'] do
    system 'find . -name "*.textile" -exec sed -i "" "s|^published: true|published: false|g" {} \;'
    system 'find . -name "*.yml" -exec sed -i "" "s|^published: true|published: false|g" {} \;'
  end

  desc 'Re-publish old posts for deployment'
  task :off => ['jekyll:clean'] do
    system 'find . -name "*.textile" -exec sed -i "" "s|^published: false|published: true|g" {} \;'
    system 'find . -name "*.yml" -exec sed -i "" "s|^published: false|published: true|g" {} \;'
  end

end