#lang racket

(require racket/date)

(printf "Today is ~s.\n"
        (date->string (seconds->date (current-seconds))))

(require setup/dirs)

(build-path (find-collects-dir)
            "racket")