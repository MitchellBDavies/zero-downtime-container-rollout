from fastapi import FastAPI
import os

app = FastAPI()


@app.get("/")
async def root():
    return {"message": "Hello World", "server_id": os.environ['SERVER'], "version": os.environ['VERSION']}

@app.get("/health", status_code=200)
async def root():
    return "OK"