FROM python:3.9.0

WORKDIR /home/

RUN echo "testing123"

WORKDIR /home/
RUN git clone https://github.com/baekkwanghyoun/jsontg_pragmatic.git
#RUN git clone https://github.com/noeul1114/pragmatic.git

WORKDIR /home/jsontg_pragmatic/

RUN python3 -m pip install --upgrade pip

RUN pip install -r requirements.txt

#RUN pip freeze > requirements.txt
#RUN pip install django
#RUN echo "SECRET_KEY=1*mlu56cl7#p5-evdtc%%t-4u)f08o21p=ak6+gvu0zv79q&u0" > .env



RUN pip install gunicorn

RUN pip install mysqlclient

EXPOSE 8000

CMD ["bash", "-c", "python manage.py collectstatic --noinput --settings=pragmatic.settings.deploy && python manage.py migrate --settings=pragmatic.settings.deploy && gunicorn pragmatic.wsgi --env DJANGO_SETTINGS_MODULE=pragmatic.settings.deploy --bind 0.0.0.0:8000"]
