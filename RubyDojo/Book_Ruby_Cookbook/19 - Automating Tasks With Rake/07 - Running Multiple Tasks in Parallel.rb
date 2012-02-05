task 'copy_docs' do
  # Simulate a large disk copy.
  sleep 5
end

task 'compile_extensions' do
  # Simulate a C compiler compiling a bunch of files.
  sleep 10
end

task 'build_serial' => ['copy_docs', 'compile_extensions']
multitask 'build_parallel' => ['copy_docs', 'compile_extensions']
#---
task 'build' => ['compile_extensions', 'run_tests', 'generate_rdoc']
#---
