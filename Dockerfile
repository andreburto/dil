FROM public.ecr.aws/lambda/python:3.8

COPY src/app.py ${LAMBDA_TASK_ROOT}

COPY src/requirements.txt  .

RUN  pip3 install -r requirements.txt --target "${LAMBDA_TASK_ROOT}"

# Set the CMD to your handler (could also be done as a parameter override outside of the Dockerfile)
CMD [ "app.handler" ]
