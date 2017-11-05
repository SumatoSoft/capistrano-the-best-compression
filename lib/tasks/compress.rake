namespace :deploy do
  desc 'Compress assets'
  task :compress_assets, :names do |_, args|
    on roles(:app) do
      assets_paths = [release_path.join('public', 'assets'), release_path.join('public', 'packs')]
      assets_paths.each do |assets_path|
        names = args[:names].is_a?(Array) && !(args[:names].empty?) ? args[:names] : %w(*.js *.css *.ico *.svg *.pdf)
        names_args = "#{names.join('" -o -name "')}"
        execute "find -L #{assets_path} \\( -name \"#{names_args}\" \\) -exec bash -c \"[ ! -f '{}.gz' ] && zopfli --gzip --i20 '{}'\" \\; "
      end
    end
  end

  desc 'Compress pngs'
  task :compress_png do
    on roles(:app) do
      assets_paths = [release_path.join('public', 'assets'), release_path.join('public', 'packs')]
      assets_paths.each do |assets_path|
        execute "find -L #{assets_path} \\( -name *.png \\) -not \\( -name 'zopflied_*.png' \\) -exec bash -c 'FULLPATH='{}'; FILENAME=${FULLPATH##*/}; BASEDIRECTORY=${FULLPATH%$FILENAME}; [ ! -f \"${BASEDIRECTORY}zopflied_${FILENAME}\" ] && zopflipng \"${FULLPATH}\" \"${BASEDIRECTORY}zopflied_${FILENAME}\" ' \\; "
      end  
    end
  end
end
