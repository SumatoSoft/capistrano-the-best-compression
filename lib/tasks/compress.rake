namespace :deploy do
  desc 'Compress assets'
  task :compress_assets, :names do |_, args|
    on roles(:app) do
      assets_path = release_path.join('public')
      names = args[:names].is_a?(Array) && !(args[:names].empty?) ? args[:names] : %w(*.js *.css *.ico *.svg *.pdf)
      names_args = "#{names.join('" -o -name "')}"
      execute "find -L #{assets_path + '{assets,packs}' } \\( -name \"#{names_args}\" \\) -exec bash -c \"[ ! -f '{}.gz' ] && zopfli --gzip --i20 '{}'\" \\; "
    end
  end

  desc 'Compress pngs'
  task :compress_png do
    on roles(:app) do
      assets_path = release_path.join('public')
      execute "find -L #{assets_path + '{assets,packs}'} \\( -name *.png \\) -not \\( -name 'zopflied_*.png' \\) -exec bash -c 'FULLPATH='{}'; FILENAME=${FULLPATH##*/}; BASEDIRECTORY=${FULLPATH%$FILENAME}; [ ! -f \"${BASEDIRECTORY}zopflied_${FILENAME}\" ] && zopflipng \"${FULLPATH}\" \"${BASEDIRECTORY}zopflied_${FILENAME}\" ' \\; "
    end
  end

  desc 'Intall compressor hooks'
  task :install_compressor_hooks do
    before 'deploy:publishing', 'deploy:compress_assets'
    before 'deploy:publishing', 'deploy:compress_png'
  end

  before :starting, :install_compressor_hooks
end
