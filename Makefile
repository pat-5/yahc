

.PHONY: all test test_suite undoc_tests \
  fizzbuzz sieve_b sieve_k toe \
  recognize msg count_todo

all: test

test: test_suite undoc_tests count_todo

msg: count_todo

test_suite: fizzbuzz sieve_b sieve_k toe recognize

yahc.pm: yahc.gen.pm
	perl yahc.gen.pm > yahc.pm

fizzbuzz: yahc.pm fizzbuzz.hoon
	perl -I. yahcfilt.pl <fizzbuzz.hoon >fizzbuzz.ast.try 2>&1
	diff fizzbuzz.ast.try fizzbuzz.ast || echo 'fizzbuzz example !FAILED!'

sieve_b: yahc.pm sieve_b.hoon
	perl -I. yahcfilt.pl <sieve_b.hoon >sieve_b.ast.try 2>&1
	diff sieve_b.ast.try sieve_b.ast || echo 'sieve_b example !FAILED!'

sieve_k: yahc.pm sieve_k.hoon
	perl -I. yahcfilt.pl <sieve_k.hoon >sieve_k.ast.try 2>&1
	diff sieve_k.ast.try sieve_k.ast || echo 'sieve_k example !FAILED!'

toe: yahc.pm toe.hoon
	perl -I. yahcfilt.pl <toe.hoon >toe.ast.try 2>&1
	diff toe.ast.try toe.ast || echo 'toe example !FAILED!'

recognize:
	prove --verbose -I. recognize.t 2>&1 | tee recognize.try

undoc_tests:

count_todo:
	echo $$(egrep 'Failed .*TODO' recognize.try | wc -l) TODO

ast_reset: yahc.pm
	perl -I. yahcfilt.pl <fizzbuzz.hoon >fizzbuzz.ast
	perl -I. yahcfilt.pl <sieve_b.hoon >sieve_b.ast
	perl -I. yahcfilt.pl <sieve_k.hoon >sieve_k.ast
	perl -I. yahcfilt.pl <toe.hoon >toe.ast

dev:
	echo empty dev target
