namespace :deploy do
  desc 'Compress assets'
  task :compress_assets, [:names] => :environment do |_, args|
    on roles(:app) do
      assets_path = release_path.join('public', 'assets')
      names = args.names.blank? ? args.names : %w(*.js *.css *.ico *.svg *.pdf)
      names_args = "#{names.join(' -name ')}"
      execute "find -L #{assets_path} \\( -name #{names_args} \\) -exec bash -c \"[ ! -f '{}.gz' ] && zopfli --gzip --i20 '{}'\" \\; "
    end
  end

  desc 'Compress pngs'
  task :compress_png => :environment do
    on roles(:app) do
      assets_path = release_path.join('public', 'assets')
      execute "find -L #{assets_path} \\( -name *.png \\) -not \\( -name 'zopflied_*.png' \\) -exec bash -c 'FULLPATH='{}'; FILENAME=${FULLPATH##*/}; BASEDIRECTORY=${FULLPATH%$FILENAME}; [ ! -f \"${BASEDIRECTORY}zopflied_${FILENAME}\" ] && zopflipng \"${FULLPATH}\" \"${BASEDIRECTORY}zopflied_${FILENAME}\" ' \\; "
    end
  end
end
