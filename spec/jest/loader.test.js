import React from 'react';
import ReactDOM from 'react-dom';

// Mocks
jest.mock('react', () => {
  // Import the actual React module
  const actualReact = jest.requireActual('react');
  return {
    ...actualReact,
    Suspense: jest.fn(({ children }) => <div>Suspense - {children}</div>),
    lazy: jest.fn(),
  };
});

jest.mock('react-dom', () => {
  const actualReactDom = jest.requireActual('react-dom');
  return {
    ...actualReactDom,
    render: jest.fn(),
  }
})

// Helper to simulate the DOMContentLoaded event
function triggerDOMContentLoaded() {
  const event = new Event('DOMContentLoaded', {
    bubbles: true,
    cancelable: true,
  });
  document.dispatchEvent(event);
}

describe('React component rendering', () => {
  beforeEach(() => {
    document.body.innerHTML = `
      <div data-behavior="react" data-component="TestComponent" data-props='{"prop1": "value1"}'></div>
    `;
    React.lazy.mockImplementation(() => jest.fn(() => <div>TestComponent</div>));
    import('@app/loader.tsx');
    triggerDOMContentLoaded();
  });

  it('should render react components when DOMContentLoaded is triggered', () => {
    expect(document.body.innerHTML).toMatch(/TestComponent/);
  });

  it('should pass the correct props to the components', () => {
    const mockComponentCall = ReactDOM.render.mock.calls[0][0].props.children;
    expect(mockComponentCall.props).toEqual({ prop1: 'value1' });
  });

  it('should call React.lazy', () => {
    expect(React.lazy).toHaveBeenCalledWith(expect.any(Function));
  });

  it('should render react components', () => {
    expect(ReactDOM.render).toHaveBeenCalled()
  });

});

