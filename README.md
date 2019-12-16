## Description of issue:
I have recently started work on a new Rails 6.0.2 project. One of my models, `vlog.rb`, can have multiple associated files, hence the `has_many_attached :files` declaration defined in `app/models/vlog.rb`.

Following the [ActiveStorage instructions](https://edgeguides.rubyonrails.org/active_storage_overview.html) I'm able to successfully upload multiple files through the web browser in the development environment, which writes the files to `storage/` as expected. Unfortunately, if I then destroy a Vlog record through the web UI, I observe that only **one** of the uploaded files is removed from the `storage/` directory, with the additional file(s) remaining on the local file system. I've also observed that whilst all `ActiveStorage::Attachment` records are deleted from the database, some of the `ActiveStorge::Blob` records fail to be removed, which I assume shares the same root cause.

## Steps to reproduce:
1) Clone this repository to your computer.
1) Run `bundle install` to fetch the dependencies of a basic Rails 6.0.2 app.
1) Run `rails db:migrate` to setup your local database.
1) Run the rails server locally, `rails server`
1) Visit http://localhost:3000/vlogs/new, press `Choose files` and select **two** files from your computer for upload to the Rails app.
1) In your file browser, open the `storage`  directory and observe that **two** directories have been created, each of which contains a subdirectory and then a copy of the file you uploaded.
1) Back in your web browser, visit http://localhost:3000/vlogs, locate the Vlog you just created and press `Destroy`
1) Revisit the `storage`  directory in your file browser and count the number of files that remain on your file system.

## Expected behaviour
1) Both (**2**) of the uploaded files has been deleted from `storage` since their parent (Vlog resource) has been destroyed. Zero files remain.

## Actual behaviour
1) Only **1** of the uploaded files has been deleted from the local `storage` directory, essentially leaving the secondary file orphaned (since the parent Vlog resource has been destroyed). One file remains.

## Additional Notes
After deleting a Vlog resource I've observed that `ActiveStorage::Attachment.count` reliably returns `0`, as you'd expected. If you run `ActiveStorage::Blob.count`, however, you'll see that this returns `1`, which I suspect relates to the file that remains within the `storage` directory.
