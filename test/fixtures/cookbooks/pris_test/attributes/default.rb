default['postgresql']['enable_pgdg_yum'] = true
default['postgresql']['version'] = '9.3'
default['postgresql']['dir'] = '/var/lib/pgsql/9.3/data'
default['postgresql']['config']['data_directory'] = '/var/lib/pgsql/9.3/data'
default['postgresql']['config']['autovacuum'] = 'on'
default['postgresql']['config']['checkpoint_timeout'] = '15min'
default['postgresql']['config']['shared_preload_libraries'] =
  'pg_stat_statements'
default['postgresql']['config']['track_activities'] = 'on'
default['postgresql']['config']['track_counts'] = 'on'
default['postgresql']['config']['vacuum_cost_delay'] = 50
default['postgresql']['pg_hba'] = [{ addr: '', db: 'all', method: 'trust',
                                     type: 'local', user: 'all' },
                                   { addr: '127.0.0.1/32', db: 'all',
                                     method: 'trust', type: 'host',
                                     user: 'all' },
                                   { addr: '::1/128', db: 'all',
                                     method: 'trust', type: 'host',
                                     user: 'all' }]
default['postgresql']['client']['packages'] = ['postgresql93',
                                               'postgresql93-contrib',
                                               'postgresql93-devel']
default['postgresql']['server']['packages'] = ['postgresql93-server']
default['postgresql']['contrib']['packages'] = ['postgresql93-contrib']
default['postgresql']['server']['service_name'] = 'postgresql-9.3'
default['postgresql']['contrib']['extensions'] = ['pageinspect',
                                                  'pg_buffercache',
                                                  'pg_freespacemap',
                                                  'pgrowlocks',
                                                  'pg_stat_statements',
                                                  'pgstattuple']
