from fastapi import FastAPI


app = FastAPI()


@app.get('/')
async def root():
    return {'message': 'Hello World! :D'}

# I am a submodule. (think add-on)
# Other files that get added here will be used in multiple places in the code.
