class Compiler < Nodo::Core
  require babelCore: '@babel/core',
          optionsObject: './babel.config.js'

  class_function def call(input)
    filename = File.basename(input[:filename])
    debugger
    source = input[:data]
    { data: compile_component(source, filename) }
  end

  function :compile_component, <<~'JS'
    (source, filename) => {
      nodo.debug(`Compiling component ${filename}`);

      const result = babelCore.transformSync(source, optionsObject)

      return result.code;
    }
  JS
end
