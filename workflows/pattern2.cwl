# Pattern 2: Efficient if-else

# cwltoil workflows/pattern2.cwl --val 0
# cwltoil workflows/pattern2.cwl --val 1  -> should give a warning
# cwltoil workflows/pattern2.cwl --val 2
 
class: Workflow
cwlVersion: v1.2
inputs:
  val: int

steps:

  # We could have used inputs.in1 but we do this to illustrate
  # How we can use additional variables in the expression that
  # are not declared in the underlying tool

  step0:
    in:
      in1: val
      a_new_var: val
    run: ../tools/foo.cwl
    when: $(inputs.a_new_var > 1)
    out: [out1]


  step1:
    in:
      in1: val
      a_new_var: val
    run: ../tools/bar.cwl
    when: $(inputs.a_new_var < 1)
    out: [out1]

outputs:
  out1: 
    type: string
    outputSource:
      - step0/out1
      - step1/out1
    branchSelect: the_one_that_ran

requirements: 
  InlineJavascriptRequirement: {}
