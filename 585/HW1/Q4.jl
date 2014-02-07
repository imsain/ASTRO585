# 4a)
N_obs = 100;
srand(42);
true_v = zeros(N_obs); #Mean is 0 m/s.
sigma_v = ones(N_obs)*2; #A st. dev. of 2.
sim_v = true_v + sigma_v.*randn(N_obs);

# 4b/c)
function prob(sim_v, sigma_v, true_v)
        N_obs = length(true_v);
        prob = zeros(true_v);
        for i in 1:N_obs
            prob[i] = exp((sim_v[i]-true_v[i])^2/(2*sigma_v[i]^2)/sqrt(2*pi*sigma_v[i]));
        end;
        return prob;
end

# 4d)

