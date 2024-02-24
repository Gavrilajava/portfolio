import React, { useState } from "react";
import useFetch from "react/hooks/useFetch";
import Spinner from "react/shared/Spinner";
import CopyIcon from "react/shared/icons/CopyIcon";
import CheckIcon from "react/shared/icons/CheckIcon";

interface URLData {
  long?: string;
  short?: string;
  copied?: boolean;
}

interface URLShortenerProps {
  urls_path: string;
  url_redirect_path: string;
}

export default function URLShortener({ urls_path, url_redirect_path }: URLShortenerProps) {

  const [{ data, error, loading }, callFetch, dispatch] = useFetch<URLData>(urls_path, 'POST', {})

  const handleSubmit = (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault()
    if (loading) return
    callFetch({long: data?.long})
  }

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    if (loading) return
    const val = e.target.value.replace(/^https?:\/\//, '')
    dispatch({ type: 'SET_DATA', data: { long: val, short: undefined } })
  }

  const shortUrl = () => {
    if (!data?.short) return ""
    return `${window.location.origin}${url_redirect_path}/${data.short}`
  }

  const copyUrl = () => {
    const url = shortUrl()
    navigator.clipboard.writeText(url)
    dispatch({ type: 'SET_DATA', data: { ...data, copied: true } })
  }

  return (
    <form className="bordered max-w-2xl md:min-w-2xl" id="url_form" onSubmit={handleSubmit}>
      <label className="label block mb-2 mt-6" htmlFor="long">Long Url</label>
      <div className="w-full flex relative">
        <span className="bg-blue input rounded-r-none pe-1">https://</span>
        <input type="text" name="long" id="long" value={data?.long} onChange={handleChange} className="flex-grow w-full input rounded-l-none ps-1" placeholder="www.gavrilchik.net" />
        {loading && <Spinner />}
      </div>
      {error && <span className="text-red text-sm">{error}</span>}
      <button type="submit" name="commit" className="button bg-purple w-full">
        Shorten
      </button>
      <label className="label block mb-2 mt-4" htmlFor="short">Short Url</label>
      <div className="w-full flex">
        <input type="text" name="short" id="short" value={shortUrl()} className={`flex-grow w-full input ${data?.short ? 'rounded-r-none' : ""}`} placeholder="Shot url will appear here" />
        {data?.short && 
        <span className="bg-green input cursor-pointer rounded-l-none" onClick={copyUrl}>
          {data?.copied ? <CheckIcon/> : <CopyIcon/> }
          </span>}
      </div>
    </form>
  )
}
