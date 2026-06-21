# Business Questions: Deutsche Bahn Delay Analysis

**Stakeholder:** A traveler who wants to minimize their chance of being delayed.

---

## Q1: What percentage of trains actually arrive on time overall?

**Why it matters:** So that I can plan my day accordingly and know how much
buffer time to add for connections.

**What I expect to find:** DB officially claims around 80% punctuality, but
based on my personal experience I think the real on-time rate is closer to
70%. I want to see if my gut feeling matches the data.

**Chart type:** Donut or KPI card showing on-time % vs delayed %.

---

## Q2: How do delays vary by station category (major hubs vs. smaller stations)?

**Why it matters:** As a traveler, knowing whether smaller stations are
more reliable (or more chaotic) than major hubs helps me plan trips.
Especially when I have a choice of where to change trains.

**What I expect to find:** I expect major hubs (category 1-2) to have
WORSE delays because they handle the most traffic and are bottlenecks
in the network. Smaller stations (category 4-5) might be more punctual
since they have fewer trains crossing each other.

**Note:** I originally planned to compare train types (ICE vs RE etc.)
but the dataset doesn't include train type as a column. After data
exploration, I adapted this question to use station category, which
the data does support.

**Chart type:** Bar chart with one bar per category (1-5).

**Sub-question:** Does the pattern hold across all states, or is it
different in densely populated regions like NRW vs rural Bayern?

## Q3: How does delay risk change by time of day?

**Why it matters:** If some hours are clearly worse than others, I can
shift my travel time or look for alternatives at specific times.

**What I expect to find:** I expect morning rush (around 7–9) and evening
rush (around 17–19) to have the worst delays. Late night and early
morning should be the most reliable since the network is less busy.

**Chart type:** Line chart with hour of day on the x-axis and average
delay on the y-axis.

---

## Q4: Does delay risk worsen across consecutive weekdays?

**Why it matters:** As a traveler, I want to know if delays accumulate
across the week (e.g., Monday clean, Wednesday chaotic) or stay roughly
constant. This affects which day to schedule important trips.

**What I expect to find:** I expect Tuesday and Wednesday to be slightly
worse than Monday because the network has less recovery time between
weekdays. The difference shouldn't be huge.

**Note:** I originally planned a full Mon-Sun weekday analysis, but
during exploration I discovered the dataset only contains 3 full days
(Mon-Wed) plus a partial Thursday morning. I adapted the question to
fit the data: comparing the 3 full weekdays available.

**Chart type:** Bar chart with one bar per date (or weekday).


---

## Q5: Do longer routes accumulate more delay than shorter ones?

**Why it matters:** As a traveler, I want to know if I should expect
more delays on long-distance journeys vs. short trips. This affects
how much buffer time to add for connections.

**What I expect to find:** Trains making more stops likely accumulate
more delay along the way. I expect a clear positive relationship between
route length (number of stops) and average delay.

**Note:** I originally planned to analyze seasonal patterns, but the
dataset only covers one week, so seasonal analysis isn't possible.
I replaced this question with one the data supports.

**Chart type:** Scatter plot with route length on x-axis and average
delay on y-axis. Or a binned bar chart (short/medium/long routes).

---

## Q6: Which stations have the worst delays?

**Why it matters:** So I can plan trips through specific hubs more
carefully. For example, adding extra buffer time if I have to change
trains at a station known for delays.

**What I expect to find:** I expect large city hubs like Frankfurt Hbf,
München Hbf, and Köln Hbf to have the worst delays because they handle
the most traffic and are bottlenecks in the network.

**Chart type:** Horizontal bar chart showing the top 10 worst stations
by average delay.
