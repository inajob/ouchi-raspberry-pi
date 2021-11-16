import requests
from datetime import datetime, timedelta, date, time
import time as timep
import json

with open('../secrets/timetree-token') as f:
    token = f.read().strip()
with open('../secrets/timetree-id') as f:
    timetreeId = f.read().strip()

headers = {
        'Authorization': 'Bearer {}'.format(token),
        'Accept': 'application/vnd.timetree.v1+json',
        }

def get_upcoming(calId):
    url = 'https://timetreeapis.com/calendars/{}/upcoming_events?timezone=Asia/Tokyo&days=7&include=label'.format(calId)
    r = requests.get(url, headers=headers, timeout=(3.0,7.5))
    return r.json()

def get_today_schedule(d, items):
    ret = []
    labels = {}
    for item in items['included']:
        if(item['type'] == 'label'):
            labels[item['id']] = item['attributes']['color']
    for item in items['data']:
        date_format = "%Y-%m-%dT%H:%M:%S.%fZ"
        startAt = datetime.strptime(item['attributes']['start_at'], date_format) + timedelta(hours=+9)
        endAt = datetime.strptime(item['attributes']['end_at'], date_format) + timedelta(hours=+9)
        title = item['attributes']['title']
        p1 = max(d, startAt)
        p2 = min(d + timedelta(1), endAt)
        #print(item)
        if p1 <= p2:
            #if startAt == endAt:
            #    # all day schedule
            #    print("{} {}".format(startAt.strftime("%m/%d %H:%M"), title))
            #else:
            #    print("{} {} {}".format(startAt.strftime("%m/%d %H:%M"), endAt.strftime("%m/%d %H:%M"), title))
            item['start_at'] = (startAt)
            item['end_at'] = (endAt)
            item['labelColor'] = labels[item['relationships']['label']['data']['id']]
            ret.append(item)
        else:
            pass
    return ret

def get():
  retry = True
  while retry:
    retry = False
    try:
      items = get_upcoming(timetreeId)
    except Exception as e:
      retry = True
      print("detect get error")
      print(e)
      timep.sleep(60)
      print("retry...")
      continue
    start = datetime.combine(date.today(), time())
    startDate = date.today()
    ret = []
    for i in range(9):
        #print('========')
        #print((start + timedelta(i)).strftime("%m/%d"))

        ret.append({
            "date": startDate + timedelta(i),
            "items": get_today_schedule(start + timedelta(i), items)
                })
  return ret

def json_serial(obj):
    if isinstance(obj, (datetime, date)):
        return obj.isoformat()
    raise TypeError ("Type %s not serializable" % type(obj))


if __name__=='__main__':
  obj = get()
  #print(obj);
  sobj = json.dumps(obj, default=json_serial); 
  print("var schedule = " + sobj + ";");


