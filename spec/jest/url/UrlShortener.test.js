import React from 'react';
import { render, fireEvent, waitFor } from '@testing-library/react';
import '@testing-library/jest-dom'
import URLShortener from '@app/urls/URLShortener';
import useFetch from '@hooks/useFetch';

jest.mock('@hooks/useFetch', () => jest.fn());
jest.mock('@shared/Spinner', () => () => <div>Spinner</div>);
jest.mock('@shared/icons/CopyIcon', () => () => <div data-testid="copy-icon">CopyIcon</div>);
jest.mock('@shared/icons/CheckIcon', () => () => <div>CheckIcon</div>);
navigator.clipboard = { writeText: jest.fn() };

describe('URLShortener', () => {
  const mockCallFetch = jest.fn();
  const mockDispatch = jest.fn();
  const urls_path = '/some-path';
  const url_redirect_path = '/redirect';

  beforeEach(() => {
    useFetch.mockImplementation(() => ([{ data: {}, loading: false, error: null }, mockCallFetch, mockDispatch]));
  });

  it('renders the form correctly', () => {
    const { getByLabelText, getByPlaceholderText } = render(<URLShortener urls_path={urls_path} url_redirect_path={url_redirect_path} />);
    expect(getByLabelText('Long Url')).toBeInTheDocument();
    expect(getByPlaceholderText('www.gavrilchik.net')).toBeInTheDocument();
    expect(getByLabelText('Short Url')).toBeInTheDocument();
    expect(getByPlaceholderText('Shot url will appear here')).toBeInTheDocument();
  });

  it('should display error message', () => {
    useFetch.mockReturnValue([{ data: null, error: 'Error message', loading: false }, jest.fn(), mockDispatch]);
    const { getByText } = render(<URLShortener urls_path="test/path" url_redirect_path="redirect/path" />);
    expect(getByText('Error message')).toBeInTheDocument();
  });

  it('should handle input change', () => {
    const { getByLabelText } = render(<URLShortener urls_path="test/path" url_redirect_path="redirect/path" />);
    const input = getByLabelText(/long url/i);
    fireEvent.change(input, { target: { value: 'https://example.com' } });
    expect(mockDispatch).toHaveBeenCalledWith({ type: 'SET_DATA', data: { long: 'example.com', short: undefined } });
  });

  it('should handle form submission', () => {
    const mockCallFetch = jest.fn();
    useFetch.mockReturnValue([{ data: { long: 'example.com' }, error: null, loading: false }, mockCallFetch, mockDispatch]);
    const { getByRole } = render(<URLShortener urls_path="test/path" url_redirect_path="redirect/path" />);
    fireEvent.submit(getByRole('form'));
    expect(mockCallFetch).toHaveBeenCalledWith({ long: 'https://example.com' });
  });

  it('should display short URL and handle copy', async () => {
    useFetch.mockReturnValue([{ data: { long: 'example.com', short: 'abc123', copied: false }, error: null, loading: false }, jest.fn(), mockDispatch]);
    const { getByLabelText, getByTestId } = render(<URLShortener urls_path="test/path" url_redirect_path="redirect/path" />);
    const shortUrlInput = getByLabelText(/short url/i);
    expect(shortUrlInput.value).toContain('abc123');

    const copyButton = getByTestId('copy-icon');
    fireEvent.click(copyButton);
    expect(navigator.clipboard.writeText).toHaveBeenCalledWith(expect.stringContaining('abc123'));
    expect(mockDispatch).toHaveBeenCalledWith({ type: 'SET_DATA', data: { long: 'example.com', short: 'abc123', copied: true } });
  });


});
