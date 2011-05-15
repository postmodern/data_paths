### 0.3.0 / 2011-05-14

* Added {DataPaths::Finders#load_yaml_file}.
* Added {DataPaths::Finders#load_yaml_files}.
* Added {DataPaths::Finders#glob_data_paths}.
* Renamed `DataPaths::Methods#register_data_dir` to
  {DataPaths::Methods#register_data_path}.
* Renamed `DataPaths::Methods#unregister_data_dir` to
  {DataPaths::Methods#unregister_data_path}.
* Renamed `DataPaths::Methods#unregister_data_dirs` to
  {DataPaths::Methods#unregister_data_paths}.
* Renamed `DataPaths.unregister!` to {DataPaths.unregister}.
* Changed {DataPaths.paths} to be an `Array`, so order of the registered
  paths is preserved.
* Fixed a bug where {DataPaths::Finders} was needlessly including
  `Enumerable`.

### 0.2.1 / 2010-04-13

* Minor bug-fix in {DataPaths::Methods#unregister_data_dirs!}.

### 0.2.0 / 2010-04-13

* Renamed the static_paths gem to data_paths, since the `data/` directory
  is the prefered directory for storing static-content in Ruby libraries.

### 0.1.0 / 2010-01-22

* Initial release:

