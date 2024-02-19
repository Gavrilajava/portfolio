document.addEventListener('DOMContentLoaded', async () => {

  interface ComponentNode extends HTMLElement {
    dataset: {
      component: string;
      props: string;
      [key: string]: string;
    };
  }

  interface ComponentNodeCollection {
    [key: string]: ComponentNode[];
  }

  interface Props {
    [key: string]: any;
  }

  const reactContainersNodelist = document.querySelectorAll('[data-behavior="react"]')

  if (reactContainersNodelist.length) {

    const React = await import('react')
    const ReactDOM = await import('react-dom')

    const reactContainers = Array.from(reactContainersNodelist).reduce((result: ComponentNodeCollection, el: ComponentNode) => {

      result[el.dataset.component] ||= []
      result[el.dataset.component].push(el)
      return result

    }, {})

    const App = (Component: React.FC<Props>, props: Props) => {

      return (
        <React.Suspense fallback={<div>Loading...</div>}>
          <Component {...props} />
        </React.Suspense>
      )

    }

    Object.entries(reactContainers).forEach(([path, nodes]) => {
      const Component = React.lazy(() => import(path))

      for (const node of nodes) {
        ReactDOM.render(App(Component, JSON.parse(node.dataset.props || "{}")), node)
      }

    })

  }
})