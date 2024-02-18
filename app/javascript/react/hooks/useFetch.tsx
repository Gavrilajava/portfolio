import { useReducer, Reducer, Dispatch } from 'react';

interface FetchState<T> {
  data: T | null;
  error: string | null;
  loading: boolean;
}

type FetchAction<T> =
  | { type: 'SET_LOADING' }
  | { type: 'SET_ERROR', error: string }
  | { type: 'SET_DATA', data: T };

function fetchReducer<T>(state: FetchState<T>, action: FetchAction<T>): FetchState<T> {
  switch (action.type) {
    case 'SET_LOADING':
      return { ...state, loading: true };
    case 'SET_ERROR':
      return { ...state, loading: false, error: action.error };
    case 'SET_DATA':
      return { ...state, loading: false, error: null, data: action.data };
    default:
      return state;
  }
}

const useFetch = <T,>(
  path: string,
  method: string = 'GET',
  initialData: T | null
): [FetchState<T>, (body: any) => void, Dispatch<FetchAction<T>>] => {

  const [state, dispatch] = useReducer<Reducer<FetchState<T>, FetchAction<T>>>(fetchReducer, {
    data: initialData,
    error: null,
    loading: false,
  });

  const callFetch = (body: any): void => {
    dispatch({ type: 'SET_LOADING' });

    const element = document.querySelector(`meta[name='csrf-token']`) as HTMLMetaElement;
    if (element && element.content) {
      const requestHeaders = new Headers();
      requestHeaders.set('Content-Type', 'application/json');
      requestHeaders.set('Accept', 'application/json');
      requestHeaders.set('X-CSRF-Token', element.content);

      fetch(path, {
        method,
        headers: requestHeaders,
        body: body ? JSON.stringify(body) : undefined,
      })
        .then(resp => resp.json())
        .then((response: any) => {
          if (response.error) {
            dispatch({ type: 'SET_ERROR', error: response.error });
          } else {
            dispatch({ type: 'SET_DATA', data: response });
          }
        })
        .catch((errorMessage: string) => {
          dispatch({ type: 'SET_ERROR', error: errorMessage });
        });
    } else {
      dispatch({ type: 'SET_ERROR', error: 'No identity token found' });
    }
  };

  return [state, callFetch, dispatch];
};

export default useFetch;
