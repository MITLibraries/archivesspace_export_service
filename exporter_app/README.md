# Background

This repository has been modified to meet the needs of MIT. It may not meet your needs and you may want to check the upstream source this is forked from.

# What this does

- Provides a docker container that will run the `exporter_app` with credentials supplied in a file you provide named `.env`
- Harvests from a `.env` specified ArchivesSpace repository. If you just keep this running, it will pick up new and changed files.

# What did we change?

- Log to stdout instead of a file
- allow secrets to be passed via ENV
- removed git setup from workspace setup
- removed git commits, handle, and pdf creation from configured jobs

# How do I harvest?

- Clone this repository
- `cd` to the `exporter_app` directory
- create a file named `.env` add add the following lines with appropriate values
  - ASPACE_USERNAME=your_username
  - ASPACE_PASSWORD=your_passowrd
  - ASPACE_URL=https://your_archivesspace_backend_url
  - LOGLEVEL=debug
  - REPO_ID=your_repo_id
- `docker build -t aspace_harvester .`
- `docker run -it --env-file=.env -v '/FULL/PATH/TO/WHERE/YOU/WANT/FILES:/usr/src/exporter/workspace' aspace_harvester`

# How do I get a bash prompt inside the docker container?

- `docker run -it --env-file=.env -v '/FULL/PATH/TO/WHERE/YOU/WANT/FILES:/usr/src/exporter/workspace' aspace_harvester --entrypoint /bin/bash`

From there if you modify files you can run `bin/startup.sh` to do a harvest without having to rebuild. If you make changes outside of the docker container, you will need to rebuild (see above) for the container to reflect the changes.

# How do I see the files it downloads?

- If you used the sample command above, it creates a docker mount that is also persistently available from your host. Go to that path and do your thing.


# What it will probably do later, but not now

- allow saving EAD files to S3 instead of the local file system
