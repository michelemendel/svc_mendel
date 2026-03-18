# Create new python app

1. Create new python app, for example print("Hello World from Python in Docker!")
   - created hw.py
2. Run it without Docker
   - `py hw.py`
3. Wrap it with docker image
   - `docker build -t hw .`
4. Docker run
   - `docker run --rm hw`
5. Make sure your get output based on print
   - ok
