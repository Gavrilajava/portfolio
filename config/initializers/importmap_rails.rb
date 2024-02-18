Importmap::Map.class_eval do
  def cache_sweeper(watches: nil)
    if watches
      dirs = Array(watches).collect { |dir| [dir.to_s, %w[js jsx ts tsx]] }
      @cache_sweeper =
        Rails.application.config.file_watcher.new([], dirs.to_h) do
          clear_cache
        end
    else
      @cache_sweeper
    end
  end
end
