
.
├── macros/
│   ├── gen_surkey.sql        # Surrogate key generator
│   ├── test_is_positive.sql  # Custom generic data quality test (ensures amounts are positive)
│   └── format_quantity.sql   # Type casting helper (quantities are turned into whole numbers)
├── models/
│   ├── staging/              # Raw data cleaning
│   ├── intermediate/         # Business logic & Joins
│   └── business/             # Fact & Dimension tables (The Gold Layer)
├── tests/
│   └── positive_net_profit.sql     # Singular business logic test
│   └── date_integrity.sql     # Singular business logic test
└── dbt_project.yml           # Project configuration & dispatch










### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [dbt community](https://getdbt.com/community) to learn from other analytics engineers
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
