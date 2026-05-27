---
source: https://www.reddit.com/r/ObsidianMD/comments/1ong22r/its_folders_all_the_way_down/
tags:
  - clippings
---


# It’s folders all the way down

I recently came back to Obsidian to use for my TTRPG games. I went into thinking I wanted well organized folders for everything. Now I have tons of folders in folders in other folders and I’m sick of it. I’d like to change to just a handful of top level folders and use dataview(or bases once I figure them out) to see all my relevant info.

My question is: is there a pain free way to go back? I’m fairly certain that moving a note will automatically update backlinks. But it’s just SO much dragging and moving, especially when I work mainly on my phone.

And yes, I’ve made a backup of my vault before making large scale changes.

I heavily leverage Maps of Content (MoC) notes to organize my Vault. Here's my method:

To every note, add a List Property that contains the Link to the note's parent note, generally a MoC note.

I use the Templater community Plugin to auto-add the Property to every new note.

I use the Properties View core plugin to add a File Properties pane to the lower half of the right sidebar. This makes a file's Properties always visible without taking up space in the editing pane.

\[!summary

views:
  - type: table
    name: Table
    filters:
      and:
        - file.hasLink(this.file.name)
    order:
      - file.name
      - file.folder
      - file.ctime
      - file.mtime

his displays a Table of the links to all notes that link to the MoC note. (It's wrapped in a Callout to make it look nicer.)

The result is a wili-like repository. While I do use Folders, the underlying Folder structure is largely irrelevant since I rely on MoCs and Links.

==**Focus on working IN Obsidian, not ON Obsidian.**==