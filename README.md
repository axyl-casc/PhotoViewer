# PhotoViewer
App to load photos and view on the web

## Running PhotoPrism Locally

Use the `install_photoprism.sh` script in the `scripts` folder to install dependencies and launch PhotoPrism without Docker. The script clones the official source from GitHub, installs required packages (Go, Node.js, Yarn, MariaDB and ffmpeg) using `apt` on Debian/Ubuntu or `pacman` on Arch, sets up a basic `.env` file and starts the server on `http://localhost:2342`.

```
PHOTOS_PATH=~/Pictures ./scripts/install_photoprism.sh
```

Once the server is running you can index your photos:

```
./photoprism index
```

