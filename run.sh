echo "Stopping and removing containers"
docker compose down -v

echo "Packaging risk-base"
cd risk-base
mvn clean package

echo "Move to the root directory"
cd ..

echo "Packaging user-information"
cd user-information
mvn clean package

echo "Move to the root directory"
cd ..

echo "Packaging sync-user"
cd sync-user
mvn clean package

echo "Building and starting containers"
docker compose up -d --build