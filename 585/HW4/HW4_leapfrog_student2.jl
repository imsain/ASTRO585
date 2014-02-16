function derrivatives(state::Array,GM)
    r = sqrt(state[1]^2+state[2]^2)
    dvx = -GM*state[1]/r^3
    dvy = -GM*state[2]/r^3
    drx = state[3]
    dry = state[4]
  return [drx,dry,dvx,dvy]
end

function leapfrog_update_pos(state::Array,dt)
  Rx = state[1] + .5*dt*state[3]
  Ry = state[2] + .5*dt*state[4]
  newstate = [Rx,Ry,state[3],state[4]]
  return newstate
end

function leapfrog_update_both(state::Array,ds,dt)
  vx = state[3]+dt*ds[3]
  vy = state[4]+dt*ds[4]
  [state[1]+.5*dt*vx,state[2]+.5*dt*vy,vx,vy]
end


function integrate_leapfrog_student(state::Array,dt,duration,GM=1)
  N = iceil(duration/dt)
  t = 0.
  for i in 0:N
    dt_tmp = (t+dt<=duration) ? dt : duration-t;

    state = leapfrog_update_pos(state,dt_tmp)
    ds = derrivatives(state,GM)
    state = leapfrog_update_both(state,ds,dt_tmp)
    t += dt_tmp
  end
  return state
end



function calc_end_distance_leapfrog_student2(dur::Integer, dt::Float64 = 2pi/200.0, state::Vector{Float64} = [1., 0., 0., 1.] )
  #state = [1.,0.,0.,1.];
  dist_init = sqrt(state[1]^2+state[2]^2)
  phase_init = atan2(state[2],state[1])
  state = integrate_leapfrog_student(state,dt,dur*2pi)

  # Calculate three metrics of the accuracy of the integration
  dist = sqrt(state[1]^2+state[2]^2)
  phase = atan2(state[2],state[1])
  offset = sqrt(sum((state[1:2].-[1.0,0.0]).^2))
  return (dist-dist_init,phase-phase_init,offset)
end

using Base.Test
  function test_leapfrog_student(dur::Integer, dt::Float64 = 2pi/200.0)
  err = calc_end_distance_leapfrog_student(dur,dt)
  @test_approx_eq_eps(err[1], 0., 1e-6)
  @test_approx_eq_eps(err[2], 0., 1e-1)
  @test_approx_eq_eps(err[3], 0., 1e-1)
end
