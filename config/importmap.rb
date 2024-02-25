# Pin npm packages by running ./bin/importmap

pin 'application'
pin 'react-dom', preload: false # @18.2.0
pin 'react', preload: false # @18.2.0
pin 'scheduler', preload: false # @0.23.0
pin 'react/jsx-runtime', to: 'react--jsx-runtime.js', preload: false # @18.2.0

# react components
Dir['app/javascript/react/**/*'].each do |path|
  next unless path.include?('.')

  path = path.sub('app/javascript/', '')
  key = "@app/#{path.sub('react/', '').sub(/(\.jsx|\.tsx|\.ts)/, '')}"
  source = path.sub(/(\.jsx|\.tsx|\.ts)/, '.js')
  pin key, to: source, preload: false
end
