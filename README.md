# Welcome to My Portfolio Website Code Repository!

Welcome! You've reached the repository for the code of my portfolio website, a project I'm continuously developing. I won't delve into installation details or running instructions here, since the website is live and accessible at [https://gavrilchik.net](https://gavrilchik.net). Instead, let me share what I find particularly cool in this project:


## Responsive navbar made  without a single line of javascript

Check out the responsive navbar [here](app/views/layouts/_navbar.haml) and [here](app/assets/stylesheets/navbar.tailwind.css). It's entirely crafted without JavaScript. It's not that I have anything against JavaScript—in fact, it's one of my favorite languages. However, I know that web apps often accumulate scripts unnecessarily, much like barnacles on a pirate ship. One less thing to attract them. And I really like how I made the mobile view.


## TypeScript + React in a Rails Frontend

See the integration of TypeScript and React into the Rails frontend [here](config/initializers/sprockets_rails.rb), [here](app/javascript/react/loader.tsx) and [here](app/javascript/react/urls/URLShortener.tsx). I've also written an article about this approach [here](https://dev.to/gavrilarails/ruby-on-rails-with-react-on-typescript-using-importmaps-5082). This method is is a very promising way to have reactive components and classic server side rendered pages in the same app (Yes, Rails has SSR since 2004!)

## SQL Triggers in Rails

Discover the integration of SQL triggers in Rails [here](db/triggers/add_unique_short_to_urls_on_insert.sql). The concept of the trigger is relatively simple, but in my experience, it's often overlooked in large projects. People tend to forget that databases can has triggers. I believe I've positioned it in a place that every developer visits time to time.

## More to come...

---

Dive into the code, explore, and perhaps find some inspiration for your own voyages. If you have any questions or wish to discuss any of these features, don't hesitate to reach me.