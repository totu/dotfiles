#!/usr/bin/env python3
import datetime
import numpy
import matplotlib.pyplot as plt
import sys

#print(sys.argv[1:])
good_commits = [int(x) for x in sys.argv[1:]]
good_commits = [x/100*100 for x in good_commits]
good_commits.reverse()

#dates = [datetime.datetime.today() - datetime.timedelta(days=len(good_commits)-x) for x in range(len(good_commits))]
#dates = [d.strftime('%Y-%m-%d') for d in dates]
dates = [str(len(good_commits)-x)+" days ago" for x in range(len(good_commits))]

plt.plot(dates, good_commits, 'o-')
plt.title('Good commmits')
plt.ylim(0, 100)
plt.xticks(rotation=45)

plt.show()
