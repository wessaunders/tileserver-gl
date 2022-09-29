# tileserver-gl
Tileserver-gl hosted in nginx to be able to provide for SSL availability.  

### Installing
docker run -d -p 80:80 --name-*name* --restart=always -v *pathToData*:/data *pathToSslCertificates*:/certificates tileserver-gl
#### Installation details
*name* indicates the name of the container.  This is dependent on the install and can be anything.

*pathToData* indicates the location on the server that contains the tileserver data and configuration.

*pathToSslCertificates* indicates the location on the server that contains the ssl certificates (.pem files) that will be used by the container.

### Tileserver data and configuration
#### Data structure
Tileserver data should be provided in a specific folder structure.  MBTiles files should be stored in the MBTiles folder for each enviroment.  Style files, such as mapbox styles, should be stored in the Styles folder for each environment.

##### Create a folder for all the data for the map.  Then create a folder for each environment.  Each environment folder should contain an MBTiles folder and a Styles folder.

For example, if the root data folder on the server was named MapData and an enviroment named Test was being set up, the resulting folder structure would look like this:
* MapData
  * Test
    * MBTiles
    * Styles

#### Configuration
* Create a file called config.json.  This will the configuration for a specific environment, so save it in the appropriate environment folder.  You will need a separate config.json file for each environment.
* Populate the config.json file with the following structure:
  ``` 
  {
    "options": {
      "paths": {
        "root": "",
        "fonts: "",
        "sprites": "",
        "styles": "Styles",
        "mbtiles": "MBTiles"
      },
      "domains": [
        "localhost:8080",
        "127.0.0.1:8080"
      ],
      "formatQuality": {
        "jpeg": 80,
        "webp": 90
      },
      "maxScaleFactor": 3,
      "maxSize": 2048,
      "pbfAlias": "pbf",
      "serveAllFonts": false,
      "serveAllStyles": true,
      "serveStaticMaps": true,
      "tileMargin": 0
    },
    "styles": {
     <styles>
    },
    "data": {
      <data>
    }
  }
  ```
* \<styles\> should be set up in the following manner:
  * For each style available to the client, a section defining that style and where to find it needs to be defined.
  * The styles files are stored in the Styles subdirectory.  Each style should be named the same as the style section.
  * For example, if a client has styles called Day and Night, the Styles folder should contain style files named Day.json and Night.json, and the styles section would be defined as follows:
  ```
  "styles": {
    "Day": {
      "style": "Day.json",
      "serve_rendered": true,
      "serve_data": true
    },
    "Night": {
      "style": "Night.json",
      "serve_rendered": true,
      "serve_data": true
    }
  }
  ```
* \<data\> should be set up in the following manner:
  * For each layer that will be available to the client, a section defining that layer and where to find the mbtiles file needs to be defined
  * The mbtiles files are stored in the MBTiles subdirectory associated with each environment, such as /MapData/Test/MBTiles for an environment named Test
  * If a client has a layer called Streets, it would be defined as follows:
  ```
  "Fire": {
    "mbtiles": <name_of_streets_mbtiles_file>,
    "type": "vector"
  }
  ```
  * Substitute the actual name of the mbtiles file for the *name_of_streets_mbtiles_file* placeholder
  * Multiple mbtiles can be set up in the same way:
  ```
  "data": {
    "Streets": {
      "mbtiles": "Streets.mbtiles",
      "type": "vector"
    },
    "Milemarkers": {
      "mbtiles": "Milemarkers.mbtiles",
      "type": "vector"
    },
    "Buildings": {
      "mbtiles": "Buildings.mbtiles",
      "type": "vector"
    }
  }
  ```
  
## Code
Tileserver-gl is developed and maintained at [[maptiler/tileserver-gl](https://github.com/maptiler/tileserver-gl)](https://github.com/maptiler/tileserver-gl).  
  
## Documentation
Full documentation for tileserver-gl is available at [https://tileserver.readthedocs.io/](https://tileserver.readthedocs.io/). 
