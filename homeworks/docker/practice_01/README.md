# Change the Dinner Suggestion to New Menu with new tag and expose port

Note: d is aliased to docker

## Main task

1. Based on lab-04, change the title **Dinner Suggestion** to **New Menu Dinner Suggestion**
2. Set a new tag image 1.01
   - `d build -t dinner:1.01 .`
3. Docker run with new port 5001
   - `d run --rm -p 5001:5000 dinner:1.01`
4. Browse via google chrome
   - `http://localhost:5001`
   - `curl http://localhost:5001`

## Bonus

- `d build -t mmendel/svc-dinner:1.01 .`
- `d push mmendel/svc-dinner:1.01`
