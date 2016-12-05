task :compress_assets do
  on roles(:app) do
    assets_path = release_path.join('public', 'assets')
    execute "find -L #{assets_path} \\( -name *.js -o -name *.css -o -name *.ico -o -name *.svg -o -name *.pdf \\) -exec bash -c \"[ ! -f '{}.gz' ] && zopfli --gzip --i20 '{}'\" \\; "
  end
end

task :compress_png do
  on roles(:app) do
    assets_path = release_path.join('public', 'assets')
    execute "find -L #{assets_path} \\( -name *.png \\) -not \\( -name 'zopflied_*.png' \\) -exec bash -c 'FULLPATH='{}'; FILENAME=${FULLPATH##*/}; BASEDIRECTORY=${FULLPATH%$FILENAME}; [ ! -f \"${BASEDIRECTORY}zopflied_${FILENAME}\" ] && zopflipng \"${FULLPATH}\" \"${BASEDIRECTORY}zopflied_${FILENAME}\" ' \\; "
  end
end