My system isn't Zettelkasten, but it is based on it.

One of the best uses i've found, make a base to list out Orphan notes.

Because the only other way to visualize Orphans natively is to look in the global graph. Because the global graph gets so populated, to even make this semi-effective, it means you are also forced by necessity to:

1. Implement a tag, to keep all Orphans grouped in one place for easier navigation. Not ideal because it makes each orphan *seem like* they're related, even if they're not. Also trying to bulk delete a tag is still annoying, so i recommend avoiding tags where possible anyway, because they're "sticky". Once you create a `#tag` on a significant number of notes it's probably gonna stay there, because it's a chore to remove it.

2. Use the plugin like persistent graph. Because with enough Orphan notes, even if they are clustered around the same tag, if they move each time you open the global graph it's disorienting. Using the plugin itself isn't too much trouble, other then the annoying fact you have to run the save command when you create new notes.

By using a base, it means you don't have to rely on the global graph at all / avoid the shenanigans of tag management (1) since you have this other abstract way of tracking Orphans.

### My implementation

I created a base, then 2 properties:

- Link Count : `file.links.map(value.asFile()).filter(value.isTruthy()).length`
- Backlink Count : `file.backlinks.length`

Then for filters i did:

- folders : contain any of ~ <folder names>
- file extension : is md
- Link Count : = 0
- Backlink Count : = 0

Specifying folders is necessary, for example i have a people folder. Stores some details of personal contacts, people of interest, fictional characters, etc. Not all people are gonna be linked to other stuff, making looking for orphans in that folder redundant.

File extensions, I don't care about `.base` files, they're gonna be orphans anyway. Don't really care about images, or other stuff either, i only want the notes. You might be different.

Each of the Link filters are pretty self explanatory.

To finish up drag it into a sidebar



- [x] also add local graph view to left sidebar and the orphan thingy I right sidebar ✅ 2025-11-13
[An Opinionated Guide to Obsidian for Studying & Research](https://obsidian-guide.neocities.org/guide)
https://www.reddit.com/r/ObsidianMD/s/qCd1Z6UeBD
https://www.reddit.com/r/archlinux/s/xgfC4IlWEP