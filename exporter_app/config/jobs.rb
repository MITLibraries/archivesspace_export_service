{
  jobs: [
    WeekdayJob.new(:identifier => 'ead',
                   :description => 'Export EAD versions of resource records',
                   :days_of_week => ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'],
                   :start_time => '00:00',
                   :end_time => '23:59',
                   :minimum_seconds_between_runs => 5,

                   :task => ExportEADTask,
                   :task_parameters => {
                     # Force this job to create a git commit periodically
                     # :commit_every_n_records => 50,
                     :search_options => {
                      :repo_id => ENV['REPO_ID']
#                       :identifier => 'AAA.02.G',
#                       :start_id => 'AAA.01',
#                       :end_id => 'ZZZ.99',
                     },
                     :export_options => {
                       :include_unpublished => false,
                       :include_daos => true,
                       :numbered_cs => false
                     },

                     :generate_handles => false,

                     :xslt_transforms => ['config/transform.xslt'],
                     # :validation_schema => ['config/ead.xsd'],
                     :schematron_checks => ['config/schematron.sch'],
                   },

                   :before_hooks => [
                     ShellRunner.new("scripts/prepare_workspace.sh"),
                   ],

                   :after_hooks => [
#                     Example showing options that FopPdfGenerator accepts
#                     FopPdfGenerator.new('config/as-ead-pdf.xsl', :no_git => true, :xconf_file => 'config/fop.xconf'),
                     # FopPdfGenerator.new('config/as-ead-pdf.xsl'),
                     ErbRenderer.new("templates/manifest.md.erb", "README.md"),
                     # ShellRunner.new("scripts/commit_workspace.sh"),
                   ])
  ]
}
