import { renderHook, act } from '@testing-library/react-hooks';
import useFetch from '@hooks/useFetch'; // Adjust the path to where your hook is located

describe('useFetch Hook', () => {
  global.fetch = jest.fn(() =>
    Promise.resolve({
      json: () => Promise.resolve({}),
    })
  );

  beforeEach(() => {
    fetch.mockClear();
  });

  xit('should set loading state on callFetch', () => {
    const { result } = renderHook(() => useFetch('/test', 'GET', null));

    act(() => {
      result.current[1](); // callFetch
    });

    expect(result.current[0].loading).toBe(true);
  });

  xit('should handle data fetch successfully', async () => {
    const mockData = { some: 'data' };
    fetch.mockImplementationOnce(() =>
      Promise.resolve({
        json: () => Promise.resolve(mockData),
      })
    );

    const { result, waitForNextUpdate } = renderHook(() => useFetch('/test', 'GET', null));

    act(() => {
      result.current[1](); // callFetch
    });

    await waitForNextUpdate();

    expect(result.current[0].loading).toBe(false);
    expect(result.current[0].data).toEqual(mockData);
    expect(result.current[0].error).toBeNull();
  });

  xit('should handle fetch error', async () => {
    const errorMessage = 'Failed to fetch';
    fetch.mockImplementationOnce(() =>
      Promise.reject(new Error(errorMessage))
    );

    const { result, waitForNextUpdate } = renderHook(() => useFetch('/test', 'GET', null));

    act(() => {
      result.current[1](); // callFetch
    });

    await waitForNextUpdate();

    expect(result.current[0].loading).toBe(false);
    expect(result.current[0].error).toBe(errorMessage);
  });
});
