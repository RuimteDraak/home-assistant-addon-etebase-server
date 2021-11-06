docker build --build-arg BUILD_FROM="homeassistant/amd64-base-python" -t local/hassio-etebase .

# run: 
# create a data folder with options.json and update the volume path
# docker run --rm -it -v "./data:/data" -p 80:8080 local/hassio-etebase