# In Every Language
In Every Language is a collection of popular programming puzzles solutions in every language. Or, at least, a lot of languages. The collection is always growing, and the existing solutions are always being improved. The gist is this: these are the best programming solutions in every language.

## Development
InEveryLang is a somewhat-messy Middleman project. At the time I originally wrote it I was kind of nerding out on static site generators, and I also didn't really think I would open it up. If you're confused about something, submit an issue and I will clarify.

But, it should run just like any other ruby/middleman project.

1. Clone it
2. `bundle install`
3. `middleman`

Those 3 simple steps should get you up and running on [your localhost](http://localhost:4567).

## Adding Puzzles

There's a couple things you have to do in order to add a brand new puzzle.

1. Add the new puzzle folder

  Check out [the puzzles folder](source/puzzles/) - there's a folder there for every puzzle type we have. You just need to add a folder for the new puzzle type.

  Keep in mind that the name of the folder will be the slug in the URL, so please choose something that is readable and kinda SEO friendly. For instnace, if your puzzle is named "Bob the Builder", name the folder `bob-builder`.

2. Add the puzzle to [puzzles.yaml](data/puzzles.yaml)

  There is a YAML file in the [data folder](data/) that contains some meta data for each of the puzzles. You need to add your new puzzle type in to that file.

  **puzzleDir must be the same as the name of the folder you created in the puzzles folder**

  Please just add your puzzle to the end of the list. The ordering in that file will match the ordering on the website - you can suggest a higher position in the PR, and we can discuss that there. But, by default, use the bottom of the list.

  Also, you must have a link in your puzzle description to the actual puzzle directory. You can see examples in the other puzzle types, but essentially your description just needs a link in it like `<a href="/bob-builder">Bob the Builder</a>`.

  **Your description MUST have all special characters encoded.**

3. [Add some solutions](#adding-solutions)

  For obvious reasons, new puzzle PRs with no solutions will not be merged.

## Adding Solutions

1. Make sure the language for your solutions already exists. If not, [add it](#adding-languages)

  If the language doesn't, we won't be able to properly build the page for your solution. That's bad.

2. Create the solution in the appropriate [puzzle folder](source/puzzles/).
 
  You need to name the file as `language.txt`. The file name should match the language shortname in [languages.yml](data/languages.yml).

3. Set the source in the frontmatter

  If the code your submitting isn't yours, put a link here to wherever you got it from. If it is yours, this is your chance for some shameless self promotion - link to your portfolio, twitter, or a rickroll.

  **If you submit a solution attributed to yourself, and I find out that you are not the original source, I will remove your submission. I will also find some way to ruthlessly publicly shame you, because that's super not cool.**

4. Check your page using `middleman` server. Sometimes the code highlighting gets wacky. If it is, either fix the issue or submit an issue and I will try to fix it.

  Also, if you're submitting an update to a solution that already exists, please think very hard about _why_ your solution is better. Put that reasoning in the PR. I am not an expert in all of these languages, and will likely not know the merits of every possible solution. If I'm not convinced yours is "better", I will not merge.

## Adding Languages

In order to properly build pages, as well as represent data in [the api](source/puzzlejson.html.erb), we need to have pretty names defined for every language that solutions are written in.

If you want to add a new language (awesome! please do! that's exciting!), all you have to do is add it to the [languages.yml](data/languages.yml).

Please keep that file in alphabetical order, for sanity. Also, use a shortname (the part before the colon) that will look good in a slug, but still be pretty obvious what language you mean. For instance, if you're adding Visual Basic, make your slug `visual-basic`, instead of `vb`.

## Other Stuff

- `middleman build` is super slow. I'm pretty sure this is because of the sitemap generation. I would not be opposed to a PR that somehow makes that faster, but for now I'd suggest avoiding full builds. Just run `middleman` as a server.
- There are ads and google analytics tracking code in this project. This is not a "free, as in I'm a great guy and don't ever need money" project - I profit from this. Please don't remove those.
- Very few of the existing solutions are mine. I'm not that smart. Most of the code here is borrowed, and sourced accurately.
- InEveryLang is licensed under the Apache License 2.0.
