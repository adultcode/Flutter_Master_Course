package main

import (
	"context"
	"fmt"
	"google.golang.org/grpc"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/metadata"
	"google.golang.org/grpc/status"
	pb "grpc_server/pb"
	"log"
	"net"
	"time"
)

func validateToken(ctx context.Context) error {
	md, ok := metadata.FromIncomingContext(ctx)
	if !ok {
		return fmt.Errorf("no metadata")
	}

	values := md.Get("authorization")
	log.Printf("Invalid credentials.!.%v", md)

	if len(values) == 0 {
		return fmt.Errorf("no authorization token")
	}

	token := values[0]
	log.Printf("Invalid credentials.!.%v", token)

	if token != "token-123" { // 👈 your test token
		return fmt.Errorf("invalid token")
	}

	return nil
}

type StudentService struct {
	pb.UnimplementedStudentsServer
}

func (s *StudentService) GetUser(ctx context.Context, req *pb.GetUserRequest) (*pb.GetUserResponse, error) {
	if err := validateToken(ctx); err != nil {
		log.Printf("Invalid credentials...")

		return nil, status.Error(codes.Unauthenticated, "Invalid credentials")
	}
	user := &pb.User{
		Id:    req.Id,
		Name:  fmt.Sprintf("User %d", req.Id),
		Email: fmt.Sprintf("mail%d@google.com", req.Id),
	}
	fmt.Printf("User %+v\n", user)

	return &pb.GetUserResponse{User: user}, nil

}

func (s *StudentService) StreamUsers(req *pb.StreamUsersRequest, stream pb.Students_StreamUsersServer) error {
	log.Printf("Client connected for streaming users...")
	if err := validateToken(stream.Context()); err != nil {
		log.Printf("Invalid credential...%v", err)

		return status.Error(codes.Unauthenticated, "Invalid credentials")
	}
	// Send a fake user every 2 seconds
	ticker := time.NewTicker(2 * time.Second)
	defer ticker.Stop()

	// Counter to make fake data change
	counter := 1

	for {
		select {
		case <-ticker.C:
			user := &pb.User{
				Id:    int32(counter),
				Name:  fmt.Sprintf("Streamed User %d", counter),
				Email: fmt.Sprintf("stream%d@example.com", counter),
			}

			resp := &pb.GetUserResponse{User: user}

			if err := stream.Send(resp); err != nil {
				log.Printf("Error sending stream response: %v", err)
				return err
			}

			log.Printf("Sent user: %+v", user)
			counter++

		case <-stream.Context().Done():
			log.Println("Client disconnected from stream")
			return nil
		}
	}
}

func main() {
	listen, err := net.Listen("tcp", ":8000")
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}

	grpcServer := grpc.NewServer()
	pb.RegisterStudentsServer(grpcServer, &StudentService{})

	log.Printf("server listening at %v", listen.Addr())

	if err := grpcServer.Serve(listen); err != nil {
		log.Fatalf("failed to serve: %v", err)
	}
}
