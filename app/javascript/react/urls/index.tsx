import React, { useState } from "react";
import useFetch from "../hooks/useFetch";

interface URLData {
  long?: string;
  short?: string;
}

interface URLShortenerProps {
  url: string;
}

export default function URLShortener({ url }: URLShortenerProps) {

  const [{ data, error, loading }, callFetch, dispatch] = useFetch<URLData>(url, 'POST', {})

  const handleSubmit = (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault()
    if (loading) return
    callFetch(data)
  }

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    if (loading) return
    dispatch({ type: 'SET_DATA', data: { long: e.target.value, short: undefined } })
  }

  return (

    <form className="bordered sm:max-w-md" id="edit_user" onSubmit={handleSubmit}>
      <h1 className="text-3xl text-green">Edit your profile</h1>
      <p className="text-light-blue">You can edit your details here</p>

      <label className="label block mb-2 mt-6" htmlFor="long">Long Url</label>
      <div className="w-full flex">
        <span className="bg-blue input rounded-r-none">https://</span>
        <input type="text" name="long" id="long" value={data?.long} onChange={handleChange} className="flex-grow input rounded-l-none" placeholder="www.gavrilchik.net" />

        <div role="status" className="w-8 h-8 text-gray-200 spinner animate-spin dark:text-gray-600 fill-blue-600">
          <span className="sr-only">Loading...</span>
        </div>

      </div>
      <button type="submit" name="commit" className="button bg-purple w-full">
        Shorten
      </button>
      <label className="label block mb-2 mt-6" htmlFor="short">Short Url</label>
      <div className="w-full flex">
        <input type="text" name="short" id="short" value={data?.short} className="flex-grow input rounded-r-none" placeholder="Shotren url will appear here" />
        <span className="bg-light-blue input rounded-l-none">https://</span>
      </div>

    </form>




  )
}
